import { Inject, Injectable } from '@nestjs/common';
import { PrismaService } from './prisma/prisma.service';

import { CACHE_MANAGER } from '@nestjs/cache-manager';
import { Cache } from 'cache-manager';
import { ElasticsearchService } from '@nestjs/elasticsearch';

@Injectable()
export class AppService {
  constructor(
    private prismaService: PrismaService,
    @Inject(CACHE_MANAGER) private cacheManager: Cache,
    private elasticService: ElasticsearchService,
  ) {}

  async getProduct() {
    let dataCache = await this.cacheManager.get('product');

    if (dataCache) {
      console.log('lấy trong cache');
      return dataCache;
    }

    const productData = await this.prismaService.product.findMany();

    await this.cacheManager.set('product', productData);

    console.log('lấy từ db');
    return productData;
  }

  deleteCache() {
    this.cacheManager.reset();
    return 'Đã xóa cache';
  }

  async searchProduct(nameProduct) {
    // 1. Kiểm tra xem index đã tồn tại chưa chưa thì tạo index rồi lấy db về
    const indexExists = await this.elasticService.indices.exists({ index: 'product_index' });
  
    if (!indexExists) {
      
      
      await this.elasticService.indices.create({
        index: 'product_index'
   
      });
  
      
      let dataset = await this.prismaService.product.findMany();

      const operations = dataset.flatMap(doc => [{ index: { _index: 'product_index' } }, doc])

      const bulkResponse = await this.elasticService.bulk({ refresh: true, operations })
    
      if (bulkResponse.errors) {
        const erroredDocuments = []
        // The items array has the same order of the dataset we just indexed.
        // The presence of the `error` key indicates that the operation
        // that we did for the document has failed.
        bulkResponse.items.forEach((action, i) => {
          const operation = Object.keys(action)[0]
          if (action[operation].error) {
            erroredDocuments.push({
              // If the status is 429 it means that you can retry the document,
              // otherwise it's very likely a mapping error, and you should
              // fix the document before to try it again.
              status: action[operation].status,
              error: action[operation].error,
              operation: operations[i * 2],
              document: operations[i * 2 + 1]
            })
          }
        })
        console.log(erroredDocuments)
      }

    }
  
    // 2. Tìm kiếm sản phẩm trong Elasticsearch
    let data = await this.elasticService.search({
      index: 'product_index',
      query: {
        match: {
          "product_name": nameProduct
        },
      },
    });
  
  
  
    // 8. Trả về kết quả tìm kiếm
   
    return data;
  }
  
  
}
