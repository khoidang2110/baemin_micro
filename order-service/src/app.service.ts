import { Injectable } from '@nestjs/common';
import { PrismaService } from './prisma/prisma.service';
import { v4 as uuidv4 } from 'uuid';
@Injectable()
export class AppService {
  constructor(
    private prismaService: PrismaService,
   
  ) { }
  async createOrder(body) {
    let orderId = uuidv4(); // Tạo ID đơn hàng ngẫu nhiên
    const newOrder = {
      order_id: orderId,
      date: new Date(),
      store_id: body.store_id,
      user_id: body.user_id,
      payment: body.payment,
      address: body.address,
      note: body.note,
      fee: body.fee,
      discount: body.discount,
      tracking_id: 1,
    };

    const order = await this.prismaService.orders.create({
      data: newOrder,
    });

    // Tạo giỏ hàng liên quan
    const orderCarts = body.orderCart.map((orderCart) => ({
      product_id: orderCart.product_id,
      quantity: orderCart.quantity,
      order_id: order.order_id,
    }));

    await this.prismaService.order_cart.createMany({
      data: orderCarts,
    });

    return { message: 'Order created successfully', order_id: orderId };
  
  }
}
