import { Module } from '@nestjs/common'
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard'
import { PrismaService } from '@/database/prisma/prisma.service'
import { SitesService } from './sites.service'
import { GetSiteController } from './controllers/get-site.controller'

@Module({
  imports: [],
  controllers: [GetSiteController],
  providers: [SitesService, JwtAuthGuard, PrismaService],
  exports: [SitesService],
})
export class SitesModule {}
