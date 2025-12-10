import { BadRequestException, Controller, Get, UseGuards } from '@nestjs/common'
import { OrganizationsService } from '../organizations.service'
import { JwtAuthGuard } from '@/modules/auth/guards/jwt-auth.guard'
import { CurrentUser } from '@/common/decorators/current-user-decorator'
import { TokenPayload } from '@/modules/auth/strategies/jwt.strategy'

@Controller('/users')
@UseGuards(JwtAuthGuard)
export class GetUserProfileController {
  constructor(private organizationsService: OrganizationsService) {}

  @Get('/profile')
  async getOrganization(@CurrentUser() { ctx }: TokenPayload) {
    if (!ctx.orgId) {
      throw new BadRequestException('Missing params')
    }

    const orgId = ctx.orgId

    const user = await this.organizationsService.getOrganizationById(orgId)

    return user
  }
}
