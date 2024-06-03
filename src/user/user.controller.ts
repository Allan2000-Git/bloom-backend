import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';
import { ApiBearerAuth, ApiBody, ApiOperation, ApiParam, ApiTags } from '@nestjs/swagger';
import { Request } from 'express';
import { UserEntity } from 'src/entities/user.entity';
import { SuperAdminAuthGuard } from 'src/partner-admin/super-admin-auth.guard';
import { FirebaseAuthGuard } from '../firebase/firebase-auth.guard';
import { ControllerDecorator } from '../utils/controller.decorator';
import { CreateUserDto } from './dtos/create-user.dto';
import { GetUserDto } from './dtos/get-user.dto';
import { UpdateUserDto } from './dtos/update-user.dto';
import { UserService } from './user.service';

@ApiTags('Users')
@ControllerDecorator()
@Controller('/v1/user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Post()
  @ApiOperation({
    description: 'Stores basic profile data for a user',
  })
  @ApiBody({ type: CreateUserDto })
  async createUser(@Body() createUserDto: CreateUserDto): Promise<GetUserDto> {
    return await this.userService.createUser(createUserDto);
  }

  @ApiBearerAuth('access-token')
  @ApiOperation({
    description:
      'Returns user profile data with their nested partner access, partner admin, course user and session user data.',
  })
  @Get('/me')
  @UseGuards(FirebaseAuthGuard)
  async getUserByFirebaseId(@Req() req: Request): Promise<GetUserDto> {
    return req['user'];
  }

  /**
   * This POST endpoint deviates from REST patterns.
   * Please use `getUserByFirebaseId` above which is a GET endpoint.
   * Do not delete this until frontend usage is migrated.
   */
  @ApiBearerAuth('access-token')
  @ApiOperation({
    description:
      'Returns user profile data with their nested partner access, partner admin, course user and session user data.',
  })
  @Post('/me')
  @UseGuards(FirebaseAuthGuard)
  async getUserProfileByFirebaseId(@Req() req: Request): Promise<GetUserDto> {
    return req['user'];
  }

  @ApiBearerAuth()
  @Delete()
  @UseGuards(FirebaseAuthGuard)
  async deleteUser(@Req() req: Request): Promise<UserEntity> {
    return await this.userService.deleteUser(req['user'].user as UserEntity);
  }

  // This route must go before the Delete user route below as we want nestjs to check against this one first
  @ApiBearerAuth('access-token')
  @Delete('/cypress')
  @UseGuards(SuperAdminAuthGuard)
  async deleteCypressUsers(): Promise<UserEntity[]> {
    return await this.userService.deleteCypressTestUsers();
  }

  @ApiBearerAuth('access-token')
  @Delete('/cypress-clean')
  @UseGuards(SuperAdminAuthGuard)
  async cleanCypressUsers(): Promise<UserEntity[]> {
    return await this.userService.deleteCypressTestUsers(true);
  }

  @ApiBearerAuth()
  @Delete(':id')
  @ApiParam({ name: 'id', description: 'User id to delete' })
  @UseGuards(SuperAdminAuthGuard)
  async adminDeleteUser(@Param() { id }): Promise<UserEntity> {
    return await this.userService.deleteUserById(id);
  }

  @ApiBearerAuth()
  @Patch()
  @UseGuards(FirebaseAuthGuard)
  async updateUser(@Body() updateUserDto: UpdateUserDto, @Req() req: Request) {
    return await this.userService.updateUser(updateUserDto, req['user'] as GetUserDto);
  }

  @ApiBearerAuth()
  @Get()
  @UseGuards(SuperAdminAuthGuard)
  async getUsers(@Query() query) {
    const { include, fields, limit, ...userQuery } = query.searchCriteria
      ? JSON.parse(query.searchCriteria)
      : { include: [], fields: [], limit: undefined };
    return await this.userService.getUsers(userQuery, include, fields, limit);
  }
}
