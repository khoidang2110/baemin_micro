import { Controller, Inject,Get, Post, Body, Query} from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { lastValueFrom } from 'rxjs';

@Controller('product')
export class ProductController {
    constructor(
        @Inject("PRODUCT_SERVICE") private productService: ClientProxy,
    ){}

    @Get('/get-all')
   async getProduct(){
      let listProduct = await lastValueFrom( this.productService.send("get-all-product",""))

      return listProduct
    }

    @Get("/delete-cache")
    async deleteCache(){
        return await this.productService.send("delete-cache","")
    }
    @Get('/search')
    async userLogin(@Query("product_name") nameProduct){
 
       let result = await lastValueFrom( this.productService.send("search-product",nameProduct))
 
       return result
     }
}
