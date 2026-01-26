/*
  Warnings:

  - You are about to drop the column `duration` on the `estimate` table. All the data in the column will be lost.
  - You are about to drop the column `pro_profile_id` on the `estimate` table. All the data in the column will be lost.
  - You are about to drop the column `project_id` on the `estimate` table. All the data in the column will be lost.
  - You are about to drop the column `value` on the `estimate` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `invite` table. All the data in the column will be lost.
  - You are about to drop the column `cnpj` on the `organization` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `organization` table. All the data in the column will be lost.
  - You are about to drop the column `client_profile_id` on the `project` table. All the data in the column will be lost.
  - You are about to drop the column `pro_profile_id` on the `project` table. All the data in the column will be lost.
  - You are about to drop the column `status` on the `project` table. All the data in the column will be lost.
  - You are about to drop the `_ProviderProfileToService` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `client_profile` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `pro_profile` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[cpf_cnpj]` on the table `organization` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateEnum
CREATE TYPE "PaymentMethod" AS ENUM ('CREDIT_CARD', 'DEBIT_CARD', 'BOLETO', 'CASH', 'PIX', 'TRANSFER');

-- CreateEnum
CREATE TYPE "CustomerType" AS ENUM ('PF', 'PJ');

-- DropForeignKey
ALTER TABLE "_ProviderProfileToService" DROP CONSTRAINT "_ProviderProfileToService_A_fkey";

-- DropForeignKey
ALTER TABLE "_ProviderProfileToService" DROP CONSTRAINT "_ProviderProfileToService_B_fkey";

-- DropForeignKey
ALTER TABLE "client_profile" DROP CONSTRAINT "client_profile_organization_id_fkey";

-- DropForeignKey
ALTER TABLE "estimate" DROP CONSTRAINT "estimate_pro_profile_id_fkey";

-- DropForeignKey
ALTER TABLE "estimate" DROP CONSTRAINT "estimate_project_id_fkey";

-- DropForeignKey
ALTER TABLE "pro_profile" DROP CONSTRAINT "pro_profile_organization_id_fkey";

-- DropForeignKey
ALTER TABLE "project" DROP CONSTRAINT "project_client_profile_id_fkey";

-- DropForeignKey
ALTER TABLE "project" DROP CONSTRAINT "project_pro_profile_id_fkey";

-- DropIndex
DROP INDEX "organization_cnpj_idx";

-- DropIndex
DROP INDEX "organization_cnpj_key";

-- AlterTable
ALTER TABLE "estimate" DROP COLUMN "duration",
DROP COLUMN "pro_profile_id",
DROP COLUMN "project_id",
DROP COLUMN "value",
ADD COLUMN     "customerId" TEXT,
ADD COLUMN     "delivery_deadline" TEXT,
ADD COLUMN     "down_payment" DECIMAL(10,2),
ADD COLUMN     "installments" INTEGER NOT NULL DEFAULT 1,
ADD COLUMN     "organizationId" TEXT,
ADD COLUMN     "payment_method" "PaymentMethod" NOT NULL DEFAULT 'CASH',
ADD COLUMN     "warranty_terms" TEXT;

-- AlterTable
ALTER TABLE "invite" DROP COLUMN "type";

-- AlterTable
ALTER TABLE "organization" DROP COLUMN "cnpj",
DROP COLUMN "type",
ADD COLUMN     "cpf_cnpj" TEXT;

-- AlterTable
ALTER TABLE "project" DROP COLUMN "client_profile_id",
DROP COLUMN "pro_profile_id",
DROP COLUMN "status";

-- DropTable
DROP TABLE "_ProviderProfileToService";

-- DropTable
DROP TABLE "client_profile";

-- DropTable
DROP TABLE "pro_profile";

-- DropEnum
DROP TYPE "OrgType";

-- DropEnum
DROP TYPE "ProjectStatus";

-- CreateTable
CREATE TABLE "Customer" (
    "id" TEXT NOT NULL,
    "name" TEXT,
    "address" TEXT,
    "phone" TEXT,
    "email" TEXT,
    "cpfCnpj" TEXT,
    "type" "CustomerType" NOT NULL,
    "organizationId" TEXT,

    CONSTRAINT "Customer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "estimate_item" (
    "id" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "unit_value" DECIMAL(10,2) NOT NULL,
    "estimate_id" TEXT NOT NULL,
    "product_id" TEXT,

    CONSTRAINT "estimate_item_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "price" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "organizationId" TEXT,

    CONSTRAINT "product_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "organization_cpf_cnpj_key" ON "organization"("cpf_cnpj");

-- CreateIndex
CREATE INDEX "organization_id_idx" ON "organization"("id");

-- AddForeignKey
ALTER TABLE "estimate" ADD CONSTRAINT "estimate_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "organization"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "estimate" ADD CONSTRAINT "estimate_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "Customer"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Customer" ADD CONSTRAINT "Customer_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "organization"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "estimate_item" ADD CONSTRAINT "estimate_item_estimate_id_fkey" FOREIGN KEY ("estimate_id") REFERENCES "estimate"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "estimate_item" ADD CONSTRAINT "estimate_item_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "product"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "product_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "organization"("id") ON DELETE SET NULL ON UPDATE CASCADE;
