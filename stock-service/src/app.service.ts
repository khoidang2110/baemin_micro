import { Injectable } from '@nestjs/common';
import { PrismaService } from './prisma/prisma.service';


@Injectable()
export class AppService {
  constructor(private prismaService: PrismaService) {}

  async checkAndUpdateStock(orderCart) {
    for (const orderCartItem of orderCart) {
      const product = await this.prismaService.product.findUnique({
        where: { product_id: orderCartItem.product_id },
        select: { stock: true },
      });

      if (!product || product.stock < orderCartItem.quantity) {
        throw new Error(
          `Insufficient stock for product ID: ${orderCartItem.product_id}. Available stock: ${product?.stock}`
        );
      }

      await this.prismaService.product.update({
        where: { product_id: orderCartItem.product_id },
        data: {
          stock: {
            decrement: orderCartItem.quantity, // Trừ stock
          },
        },
      });
    }

    return { message: 'Stock updated successfully' };
  }
}
