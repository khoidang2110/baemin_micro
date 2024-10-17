import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PrismaService } from './prisma/prisma.service';
import * as bcrypt from 'bcrypt';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
@Injectable()
export class AppService {
  constructor(
    private prismaService: PrismaService,
    private jwtService: JwtService,
    private configService: ConfigService,
  ) { }
  async userLogin(data) {
    // Step 1: Check if the user exists in the database

    const {email,password} = data

    const user = await this.prismaService.users.findFirst({
      where: {
        email: email,
      },
    });

    // Step 2: If user exists, compare the password
    if (user) {
      const isPasswordValid = await bcrypt.compare(password, user.password); // Use async bcrypt.compare
      if (isPasswordValid) {
        // Step 3: Create a token without sensitive data like password
        const payload = {
          user_id: user.user_id,
          user_name: user.user_name,
          email: user.email,
          phone_number: user.phone_number,
          user_role: user.user_role,
        };

        const token = this.jwtService.sign(payload, {
          secret: this.configService.get('SECRET_KEY'),
          expiresIn: this.configService.get('EXPIRES_IN'),
        });

        return { token };  // Return the token to the client
      } else {
        throw new UnauthorizedException('Incorrect password');
      }
    } else {
      throw new UnauthorizedException('User does not exist');
    }
  }
  async signUp(body) {
    // Function to generate random user_id
    function getRandomInt(min, max) {
      min = Math.ceil(min);
      max = Math.floor(max);
      return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    try {
      // Check if username exists
      const existingUser = await this.prismaService.users.findFirst({
        where: { user_name: body.user_name },
      });

      if (existingUser) {
        return {
          status: 409,
          message: 'User already exists',
        };
      }

      // Check if email exists
      const existingEmail = await this.prismaService.users.findFirst({
        where: { email: body.email },
      });

      if (existingEmail) {
        return {
          status: 409,
          message: 'Email already exists',
        };
      }

      // Hash password
      const hashedPassword = await bcrypt.hash(body.password, 10);

      // Create new user
      await this.prismaService.users.create({
        data: {
          ...body,
          password: hashedPassword,
          user_role: 'user',
          user_id: getRandomInt(1, 100), // Generate random user ID
        },
      });

      return {
        status: 201,
        message: 'User registered successfully',
      };
    } catch (error) {
      console.error('Error creating user:', error);
      return {
        status: 500,
        message: 'Internal Server Error',
      };
    }
  }


}

