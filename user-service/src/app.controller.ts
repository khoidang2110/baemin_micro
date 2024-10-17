import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import { MessagePattern, Payload } from '@nestjs/microservices';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @MessagePattern("user-login")
  userLogin(@Payload() data) {
    return this.appService.userLogin(data);
  }

  @MessagePattern("user-sign-up")
  signUp(@Payload() data) {
    return this.appService.signUp(data);
  }
}
