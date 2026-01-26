import { Module } from '@nestjs/common'
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard'
import { PrismaService } from '@/database/prisma/prisma.service'
import { EstimatesService } from './estimates.service'
import { GetEstimatesController } from './controllers/get-organization-estimates.controller'

@Module({
  imports: [],
  controllers: [GetEstimatesController],
  providers: [EstimatesService, JwtAuthGuard, PrismaService],
  exports: [],
})
export class EstimatesModule {}
