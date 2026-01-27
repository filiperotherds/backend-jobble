import { Controller, Get, Query } from '@nestjs/common'
import { SitesService } from '../sites.service'

@Controller('/sites')
export class GetSiteController {
  constructor(private sitesService: SitesService) {}

  @Get()
  async getProfile(@Query('slug') slug: string) {
    const site = await this.sitesService.getSiteBySlug(slug)

    return site
  }
}
