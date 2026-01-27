import { PrismaService } from '@/database/prisma/prisma.service'
import { Injectable } from '@nestjs/common'

@Injectable()
export class SitesService {
  constructor(private prisma: PrismaService) {}

  async getSiteBySlug(slug: string) {
    const site = await this.prisma.site.findFirst({
      where: {
        slug: slug,
        active: true,
      },
    })

    return site
  }
}
