-- CreateTable
CREATE TABLE "Session" (
    "id" TEXT NOT NULL,
    "shop" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "isOnline" BOOLEAN NOT NULL DEFAULT false,
    "scope" TEXT,
    "expires" TIMESTAMP(3),
    "accessToken" TEXT NOT NULL,
    "userId" BIGINT,
    "firstName" TEXT,
    "lastName" TEXT,
    "email" TEXT,
    "accountOwner" BOOLEAN NOT NULL DEFAULT false,
    "locale" TEXT,
    "collaborator" BOOLEAN DEFAULT false,
    "emailVerified" BOOLEAN DEFAULT false,
    "refreshToken" TEXT,
    "refreshTokenExpires" TIMESTAMP(3),

    CONSTRAINT "Session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RegistrySettings" (
    "shop" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "accentColor" TEXT NOT NULL DEFAULT '#7c3aed',
    "eventTypes" TEXT NOT NULL DEFAULT 'Wedding,Baby shower,Birthday,Housewarming,Anniversary,Graduation,Holiday,Other',
    "defaultVisibility" TEXT NOT NULL DEFAULT 'PUBLIC',
    "maxItemsPerRegistry" INTEGER NOT NULL DEFAULT 100,
    "maxRegistriesPerUser" INTEGER NOT NULL DEFAULT 3,
    "allowGiftMessages" BOOLEAN NOT NULL DEFAULT true,
    "showPurchasedCounts" BOOLEAN NOT NULL DEFAULT true,
    "welcomeHeading" TEXT NOT NULL DEFAULT 'Gift registry',
    "welcomeText" TEXT NOT NULL DEFAULT 'Create a registry for your big day, or find a friend''s registry and give them something they truly want.',
    "secondaryColor" TEXT NOT NULL DEFAULT '#1f2937',
    "backgroundColor" TEXT NOT NULL DEFAULT '#ffffff',
    "surfaceColor" TEXT NOT NULL DEFAULT '#ffffff',
    "textColor" TEXT NOT NULL DEFAULT '#1f2328',
    "fontStyle" TEXT NOT NULL DEFAULT 'THEME',
    "cornerStyle" TEXT NOT NULL DEFAULT 'SOFT',
    "heroStyle" TEXT NOT NULL DEFAULT 'GRADIENT',
    "defaultLayout" TEXT NOT NULL DEFAULT 'GRID',
    "customCss" TEXT NOT NULL DEFAULT '',
    "allowCustomization" BOOLEAN NOT NULL DEFAULT true,
    "allowPhotos" BOOLEAN NOT NULL DEFAULT true,
    "allowAddress" BOOLEAN NOT NULL DEFAULT true,
    "showTracker" BOOLEAN NOT NULL DEFAULT true,
    "showGifterWall" BOOLEAN NOT NULL DEFAULT true,
    "analyticsEnabled" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RegistrySettings_pkey" PRIMARY KEY ("shop")
);

-- CreateTable
CREATE TABLE "Registry" (
    "id" TEXT NOT NULL,
    "shop" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "customerId" TEXT NOT NULL,
    "ownerName" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "eventType" TEXT NOT NULL DEFAULT 'Other',
    "eventDate" TIMESTAMP(3),
    "message" TEXT,
    "visibility" TEXT NOT NULL DEFAULT 'PUBLIC',
    "password" TEXT,
    "surpriseMode" BOOLEAN NOT NULL DEFAULT false,
    "status" TEXT NOT NULL DEFAULT 'ACTIVE',
    "views" INTEGER NOT NULL DEFAULT 0,
    "story" TEXT,
    "palette" TEXT NOT NULL DEFAULT 'STORE',
    "colorAccent" TEXT,
    "colorSecondary" TEXT,
    "colorBackground" TEXT,
    "fontStyle" TEXT,
    "heroStyle" TEXT,
    "layout" TEXT,
    "showGifterWall" BOOLEAN NOT NULL DEFAULT true,
    "shipEnabled" BOOLEAN NOT NULL DEFAULT false,
    "shipShowFull" BOOLEAN NOT NULL DEFAULT false,
    "shipName" TEXT,
    "shipLine1" TEXT,
    "shipLine2" TEXT,
    "shipCity" TEXT,
    "shipRegion" TEXT,
    "shipPostal" TEXT,
    "shipCountry" TEXT,
    "shipPhone" TEXT,
    "shipNote" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Registry_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RegistryItem" (
    "id" TEXT NOT NULL,
    "registryId" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "variantId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "variantTitle" TEXT,
    "handle" TEXT NOT NULL,
    "imageUrl" TEXT,
    "price" DOUBLE PRECISION NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "quantityWanted" INTEGER NOT NULL DEFAULT 1,
    "quantityPurchased" INTEGER NOT NULL DEFAULT 0,
    "priority" TEXT NOT NULL DEFAULT 'NORMAL',
    "note" TEXT,
    "position" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RegistryItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Purchase" (
    "id" TEXT NOT NULL,
    "shop" TEXT NOT NULL,
    "registryId" TEXT NOT NULL,
    "itemId" TEXT,
    "itemTitle" TEXT NOT NULL,
    "orderId" TEXT NOT NULL,
    "orderName" TEXT,
    "lineItemId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "gifterName" TEXT,
    "giftMessage" TEXT,
    "thanked" BOOLEAN NOT NULL DEFAULT false,
    "thankYouNote" TEXT,
    "shippedToRegistry" BOOLEAN NOT NULL DEFAULT false,
    "anonymous" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Purchase_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RegistryImage" (
    "id" TEXT NOT NULL,
    "shop" TEXT NOT NULL,
    "registryId" TEXT NOT NULL,
    "kind" TEXT NOT NULL,
    "mime" TEXT NOT NULL,
    "size" INTEGER NOT NULL,
    "bytes" BYTEA NOT NULL,
    "caption" TEXT,
    "position" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RegistryImage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RegistryEvent" (
    "id" TEXT NOT NULL,
    "shop" TEXT NOT NULL,
    "registryId" TEXT NOT NULL,
    "itemId" TEXT,
    "type" TEXT NOT NULL,
    "channel" TEXT,
    "visitor" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RegistryEvent_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Registry_shop_customerId_idx" ON "Registry"("shop", "customerId");

-- CreateIndex
CREATE INDEX "Registry_shop_status_idx" ON "Registry"("shop", "status");

-- CreateIndex
CREATE UNIQUE INDEX "Registry_shop_slug_key" ON "Registry"("shop", "slug");

-- CreateIndex
CREATE UNIQUE INDEX "RegistryItem_registryId_variantId_key" ON "RegistryItem"("registryId", "variantId");

-- CreateIndex
CREATE INDEX "Purchase_registryId_idx" ON "Purchase"("registryId");

-- CreateIndex
CREATE INDEX "Purchase_shop_idx" ON "Purchase"("shop");

-- CreateIndex
CREATE UNIQUE INDEX "Purchase_shop_orderId_lineItemId_key" ON "Purchase"("shop", "orderId", "lineItemId");

-- CreateIndex
CREATE INDEX "RegistryImage_registryId_kind_idx" ON "RegistryImage"("registryId", "kind");

-- CreateIndex
CREATE INDEX "RegistryImage_shop_idx" ON "RegistryImage"("shop");

-- CreateIndex
CREATE INDEX "RegistryEvent_shop_createdAt_idx" ON "RegistryEvent"("shop", "createdAt");

-- CreateIndex
CREATE INDEX "RegistryEvent_registryId_createdAt_idx" ON "RegistryEvent"("registryId", "createdAt");

-- CreateIndex
CREATE INDEX "RegistryEvent_shop_type_createdAt_idx" ON "RegistryEvent"("shop", "type", "createdAt");

-- AddForeignKey
ALTER TABLE "RegistryItem" ADD CONSTRAINT "RegistryItem_registryId_fkey" FOREIGN KEY ("registryId") REFERENCES "Registry"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Purchase" ADD CONSTRAINT "Purchase_registryId_fkey" FOREIGN KEY ("registryId") REFERENCES "Registry"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Purchase" ADD CONSTRAINT "Purchase_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "RegistryItem"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RegistryImage" ADD CONSTRAINT "RegistryImage_registryId_fkey" FOREIGN KEY ("registryId") REFERENCES "Registry"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RegistryEvent" ADD CONSTRAINT "RegistryEvent_registryId_fkey" FOREIGN KEY ("registryId") REFERENCES "Registry"("id") ON DELETE CASCADE ON UPDATE CASCADE;
