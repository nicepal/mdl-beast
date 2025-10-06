--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations`
(
    `id`           int(10) UNSIGNED NOT NULL,
    `from_id`      int(10) UNSIGNED DEFAULT NULL,
    `to_id`        int(10) UNSIGNED DEFAULT NULL,
    `message`      text COLLATE utf8mb4_unicode_ci NOT NULL,
    `status`       tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 for unread,1 for seen',
    `message_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0- text message, 1- image, 2- pdf, 3- doc, 4- voice',
    `file_name`    text COLLATE utf8mb4_unicode_ci,
    `url_details`  json DEFAULT NULL,
    `send_by`      int(10) UNSIGNED DEFAULT NULL,
    `created_at`   timestamp NULL DEFAULT NULL,
    `updated_at`   timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
    ADD PRIMARY KEY (`id`),
  ADD KEY `conversations_from_id_foreign` (`from_id`),
  ADD KEY `conversations_to_id_foreign` (`to_id`),
  ADD KEY `conversations_send_by_foreign` (`send_by`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
    MODIFY `id` int (10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for table `conversations`
--
ALTER TABLE `conversations`
    ADD CONSTRAINT `conversations_from_id_foreign` FOREIGN KEY (`from_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `conversations_send_by_foreign` FOREIGN KEY (`send_by`) REFERENCES `users` (`id`) ON
DELETE
SET NULL ON
UPDATE CASCADE,
    ADD CONSTRAINT `conversations_to_id_foreign` FOREIGN KEY (`to_id`) REFERENCES `users` (`id`)
ON
DELETE
CASCADE ON
UPDATE CASCADE;


-- --------------------------------------------------------
--
-- Table structure for table `message_action`
--

CREATE TABLE `message_action`
(
    `id`              bigint(20) UNSIGNED NOT NULL,
    `conversation_id` int(11) NOT NULL,
    `deleted_by`      int(11) NOT NULL,
    `created_at`      timestamp NULL DEFAULT NULL,
    `updated_at`      timestamp NULL DEFAULT NULL,
    `is_hard_delete`  tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for table `message_action`
--
ALTER TABLE `message_action`
    ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for table `message_action`
--
ALTER TABLE `message_action`
    MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

-- --------------------------------------------------------

--
-- Table structure for table `blocked_users`
--

CREATE TABLE `blocked_users`
(
    `id`         bigint(20) UNSIGNED NOT NULL,
    `blocked_by` int(10) UNSIGNED NOT NULL,
    `blocked_to` int(10) UNSIGNED NOT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blocked_users`
--
ALTER TABLE `blocked_users`
    ADD PRIMARY KEY (`id`),
  ADD KEY `blocked_users_blocked_by_foreign` (`blocked_by`),
  ADD KEY `blocked_users_blocked_to_foreign` (`blocked_to`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blocked_users`
--
ALTER TABLE `blocked_users`
    MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for table `blocked_users`
--
ALTER TABLE `blocked_users`
    ADD CONSTRAINT `blocked_users_blocked_by_foreign` FOREIGN KEY (`blocked_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `blocked_users_blocked_to_foreign` FOREIGN KEY (`blocked_to`) REFERENCES `users` (`id`) ON
DELETE
CASCADE ON
UPDATE CASCADE;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications`
(
    `id`           bigint(20) UNSIGNED NOT NULL,
    `owner_id`     varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
    `owner_type`   varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
    `notification` text COLLATE utf8mb4_unicode_ci         NOT NULL,
    `to_id`        bigint(20) UNSIGNED DEFAULT NULL,
    `is_read`      tinyint(1) NOT NULL DEFAULT '0',
    `read_at`      datetime DEFAULT NULL,
    `message_type` tinyint(4) NOT NULL DEFAULT '0',
    `file_name`    text COLLATE utf8mb4_unicode_ci,
    `deleted_at`   timestamp NULL DEFAULT NULL,
    `created_at`   timestamp NULL DEFAULT NULL,
    `updated_at`   timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
    ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
    MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

-- --------------------------------------------------------

--
-- Table structure for table `archived_users`
--

CREATE TABLE `archived_users`
(
    `id`          bigint(20) UNSIGNED NOT NULL,
    `owner_id`    varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
    `owner_type`  varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
    `archived_by` int(10) UNSIGNED NOT NULL,
    `created_at`  timestamp NULL DEFAULT NULL,
    `updated_at`  timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `archived_users`
--
ALTER TABLE `archived_users`
    ADD PRIMARY KEY (`id`),
  ADD KEY `archived_users_archived_by_foreign` (`archived_by`);

--
-- AUTO_INCREMENT for table `archived_users`
--
ALTER TABLE `archived_users`
    MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for table `archived_users`
--
ALTER TABLE `archived_users`
    ADD CONSTRAINT `archived_users_archived_by_foreign` FOREIGN KEY (`archived_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
