import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import { MessagePattern, Payload } from '@nestjs/microservices';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @MessagePattern("stock-task")
  createOrder(@Payload() data) {
    return this.appService.checkAndUpdateStock(data);
  }
}
