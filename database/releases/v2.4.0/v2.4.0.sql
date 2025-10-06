--
-- Table structure for table `social_accounts`
--

CREATE TABLE `social_accounts` 
(
   `id` int(10) UNSIGNED NOT NULL,
   `user_id` int(10) UNSIGNED NOT NULL,
   `provider` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
   `provider_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
   `created_at` timestamp NULL DEFAULT NULL,
   `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for table `social_accounts`
--
ALTER TABLE `social_accounts`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `social_accounts_provider_id_unique` (`provider_id`),
    ADD KEY `social_accounts_user_id_foreign` (`user_id`);

--
-- AUTO_INCREMENT for table `social_accounts`
--
ALTER TABLE `social_accounts`
    MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for table `social_accounts`
--
ALTER TABLE `social_accounts`
    ADD CONSTRAINT `social_accounts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
