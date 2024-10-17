import { Injectable } from '@nestjs/common';
import { PrismaService } from './prisma/prisma.service';

@Injectable()
export class AppService {
  constructor(private prismaService: PrismaService) {}
  async createOrderTracking(orderId) {

    const orderIdValue = typeof orderId === 'object' ? orderId.orderId : orderId;

    const orderTrackingData = {
      order_id: orderIdValue,
      tracking_id: 1,
      active: true,
    };

    await this.prismaService.order_tracking.create({
      data: orderTrackingData,
    });

    return { message: 'Shipping created successfully' };
  }
}
