ALTER TABLE `failed_jobs` ADD `uuid` VARCHAR(191) NULL DEFAULT NULL AFTER `id`, ADD UNIQUE `failed_jobs_uuid_unique` (`uuid`);
