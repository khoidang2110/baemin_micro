import { Controller, Inject,Get, Body, Post} from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { lastValueFrom } from 'rxjs';

@Controller('auth')
export class UserController {
    constructor(
        @Inject("USER_SERVICE") private userService: ClientProxy,
    ){}

    @Post('/login')
   async userLogin(@Body() body){

      let token = await lastValueFrom( this.userService.send("user-login",body))

      return token
    }


    @Post('/sign-up')
    async signUp(@Body() body){
    
        let result = await lastValueFrom(this.userService.send("user-sign-up", body))
        return result
    }

}
