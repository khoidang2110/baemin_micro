import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';

import { MessagePattern, Payload } from '@nestjs/microservices';


@Controller()
export class AppController {
  constructor(private readonly appService: AppService,){}
    

@MessagePattern("get-all-product")
order() {
  return this.appService.getProduct();
}


@MessagePattern("delete-cache")
deleteCache(){
  return this.appService.deleteCache();

}
@MessagePattern("search-product")
searchProduct(@Payload() data) {
    return this.appService.searchProduct(data);
  }


}
