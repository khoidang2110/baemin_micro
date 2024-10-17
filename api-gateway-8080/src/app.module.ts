import { Module } from '@nestjs/common';
import { ProductController } from './product/product.controller';
import { ClientsModule, Transport } from '@nestjs/microservices';
import { UserController } from './user/user.controller';
import { OrderController } from './order/order.controller';
import { ConfigModule, ConfigService } from '@nestjs/config';

@Module({
  
  imports: [
    ConfigModule.forRoot({isGlobal:true}),
    ClientsModule.registerAsync([
      {
        name: 'STOCK_SERVICE',
        imports: [ConfigModule],
        inject: [ConfigService],
        useFactory: (configService: ConfigService) => ({
          transport: Transport.RMQ,
          options: {
            urls: [process.env.RABBITMQ_URL],
            queue: 'stock_queue',
            queueOptions: {
              durable: false,
            },
          },
        }),
      },
    ]),
    ClientsModule.registerAsync([
      {
        name: 'SHIPPING_SERVICE',
        imports: [ConfigModule],
        inject: [ConfigService],
        useFactory: (configService: ConfigService) => ({
          transport: Transport.RMQ,
          options: {
            urls: [process.env.RABBITMQ_URL],
            queue: 'shipping_queue',
            queueOptions: {
              durable: false,
            },
          },
        }),
      },
    ]),
    ClientsModule.registerAsync([
      {
        name: 'ORDER_SERVICE',
        imports: [ConfigModule],
        inject: [ConfigService],
        useFactory: (configService: ConfigService) => ({
          transport: Transport.RMQ,
          options: {
            urls: [process.env.RABBITMQ_URL],
            queue: 'order_queue',
            queueOptions: {
              durable: false,
            },
          },
        }),
      },
    ]),
    ClientsModule.registerAsync([
      {
        name: 'USER_SERVICE',
        imports: [ConfigModule],
        inject: [ConfigService],
        useFactory: (configService: ConfigService) => ({
          transport: Transport.RMQ,
          options: {
            urls: [process.env.RABBITMQ_URL],
            queue: 'user_queue',
            queueOptions: {
              durable: false,
            },
          },
        }),
      },
    ]),
    ClientsModule.registerAsync([
      {
        name: 'PRODUCT_SERVICE',
        imports: [ConfigModule],
        inject: [ConfigService],
        useFactory: (configService: ConfigService) => ({
          transport: Transport.RMQ,
          options: {
            urls: [process.env.RABBITMQ_URL],
            queue: 'product_queue',
            queueOptions: {
              durable: false,
            },
          },
        }),
      },
    ]),
   
  ],
  controllers: [ProductController, UserController, OrderController],
  providers: [],
})
export class AppModule {}
