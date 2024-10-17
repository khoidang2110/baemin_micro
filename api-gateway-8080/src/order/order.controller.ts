import { Controller, Inject, Get, Post, Body, Query } from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { lastValueFrom } from 'rxjs';

@Controller('order')
export class OrderController {
  constructor(
    @Inject('STOCK_SERVICE') private stockService: ClientProxy,
    @Inject('ORDER_SERVICE') private orderService: ClientProxy,
    @Inject('SHIPPING_SERVICE') private shippingService: ClientProxy,
) {}

  @Post('/create-order')
  async createOrder(@Body() body) {
    try {
      // Stock task
      const stockResult = await lastValueFrom(
        this.stockService.send('stock-task', body.orderCart)
      );

      if (!stockResult) {
        return { message: 'Stock task failed', success: false };
      }

      // Order task
      const orderResult = await lastValueFrom(
        this.orderService.send('order-task', body)
      );

      if (!orderResult) {
        return { message: 'Order task failed', success: false };
      }

      // Shipping task
      const shippingResult = await lastValueFrom(
        this.shippingService.send('shipping-task', { orderId: orderResult.order_id })
      );

      if (!shippingResult) {
        return { message: 'Shipping task failed', success: false };
      }

      return { message: 'Order created successfully', success: true };
    } catch (error) {
      return { message: 'An error occurred', success: false, error: error.message };
    }
  }
}
