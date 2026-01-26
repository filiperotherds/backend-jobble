import { PrismaService } from '@/database/prisma/prisma.service'
import { BadRequestException, Injectable } from '@nestjs/common'

@Injectable()
export class OrganizationsService {
  constructor(private prisma: PrismaService) {}

  async getOrganizationByUserId(id: string) {
    const result = await this.prisma.user.findUnique({
      where: {
        id,
      },
      select: {
        member: {
          select: {
            organizationId: true,
            role: true,
          },
        },
      },
    })

    if (!result?.member) {
      throw new BadRequestException('Member Not Found.')
    }

    const { organizationId, role } = result.member

    const organization = await this.prisma.organization.findUnique({
      select: {
        name: true,
        avatarUrl: true,
        cpfCnpj: true,
        email: true,
      },
      where: {
        id: organizationId,
      },
    })

    const ctx = {
      organization,
      role,
    }

    return ctx
  }
}
