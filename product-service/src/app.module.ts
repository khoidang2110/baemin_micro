import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma/prisma.module';
import { ConfigModule } from '@nestjs/config';
import { RedisModule } from './redis/redis.module';
import { ElasticModule } from './elastic/elastic.module';

@Module({
  imports: [ConfigModule.forRoot({isGlobal:true}), PrismaModule, RedisModule, ElasticModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
