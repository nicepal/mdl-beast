--
-- Table structure for table `user_notifications`
--

CREATE TABLE `user_notifications`
(
    `id`          bigint(20) UNSIGNED NOT NULL,
    `title`       varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `type`        varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` text COLLATE utf8mb4_unicode_ci,
    `read_at`     timestamp NULL DEFAULT NULL,
    `user_id`     int(10) UNSIGNED DEFAULT NULL,
    `created_at`  timestamp NULL DEFAULT NULL,
    `updated_at`  timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for table `user_notifications`
--
ALTER TABLE `user_notifications`
    ADD PRIMARY KEY (`id`),
  ADD KEY `user_notifications_user_id_foreign` (`user_id`);

--
-- AUTO_INCREMENT for table `user_notifications`
--
ALTER TABLE `user_notifications`
    MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for table `user_notifications`
--
ALTER TABLE `user_notifications`
    ADD CONSTRAINT `user_notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
