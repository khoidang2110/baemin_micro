import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { MicroserviceOptions, Transport } from '@nestjs/microservices';

async function bootstrap() {
  const app = await NestFactory.createMicroservice<MicroserviceOptions>(
    AppModule,
    {
      transport: Transport.RMQ,
      options: {
        urls: [process.env.RABBITMQ_URL],
        queue: 'product_queue',
        queueOptions: {
          durable:false, // server rabbitMQ restart: false queue sẽ mất
        },
      },
    },
  );

  await app.listen();
}
bootstrap();