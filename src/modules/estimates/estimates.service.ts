import { PrismaService } from '@/database/prisma/prisma.service'
import { BadRequestException, Injectable } from '@nestjs/common'

@Injectable()
export class EstimatesService {
  constructor(private prisma: PrismaService) {}

  async getOrganizationEstimates(sub: string) {
    const result = await this.prisma.user.findUnique({
      where: {
        id: sub,
      },
      select: {
        member: {
          select: {
            organizationId: true,
          },
        },
      },
    })

    if (!result?.member) {
      throw new BadRequestException('Organization Not Found.')
    }

    const { organizationId } = result.member

    const estimates = await this.prisma.estimate.findMany({
      where: {
        organizationId,
      },
      include: {
        customer: {
          select: {
            name: true,
            address: true,
            email: true,
            phone: true,
          },
        },
        items: true,
      },
    })

    return estimates
  }
}
