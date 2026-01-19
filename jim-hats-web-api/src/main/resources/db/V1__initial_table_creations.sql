CREATE TABLE "permissions"(
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL
);
ALTER TABLE "permissions"
ADD PRIMARY KEY("id");
CREATE TABLE "app_roles"(
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL
);
ALTER TABLE "app_roles"
ADD PRIMARY KEY("id");
CREATE TABLE "app_roles_assignments"(
    "id" BIGINT NOT NULL,
    "app_role_id" BIGINT NOT NULL,
    "permission_id" BIGINT NOT NULL
);
ALTER TABLE "app_roles_assignments"
ADD PRIMARY KEY("id");
CREATE TABLE "users"(
    "id" BIGINT NOT NULL,
    "first_name" VARCHAR(255) NOT NULL,
    "last_name" VARCHAR(255) NOT NULL,
    "username" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "profile_picture_url" VARCHAR(255) NULL,
    "password" VARCHAR(255) NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NOT NULL
);
ALTER TABLE "users"
ADD PRIMARY KEY("id");
CREATE TABLE "gym_challenges"(
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "banner_img_url" VARCHAR(255) NOT NULL,
    "created_at" DATE NOT NULL,
    "start_at" DATE NOT NULL,
    "end_at" DATE NOT NULL
);
ALTER TABLE "gym_challenges"
ADD PRIMARY KEY("id");
CREATE TABLE "gym_challenge_memberships"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "gym_challenge_id" BIGINT NOT NULL,
    "role_id" BIGINT NOT NULL,
    "created_at" DATE NOT NULL
);
ALTER TABLE "gym_challenge_memberships"
ADD PRIMARY KEY("id");
CREATE TABLE "exercise_check_ins"(
    "id" BIGINT NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "created_at" DATE NOT NULL,
    "user_id" BIGINT NOT NULL,
    "exercise_img_url" VARCHAR(255) NOT NULL
);
ALTER TABLE "exercise_check_ins"
ADD PRIMARY KEY("id");
CREATE TABLE "exercise_check_in_to_challenge_assigments"(
    "id" BIGINT NOT NULL,
    "exercise_check_in_id" BIGINT NOT NULL,
    "gym_challenge_id" BIGINT NOT NULL
);
ALTER TABLE "exercise_check_in_to_challenge_assigments"
ADD PRIMARY KEY("id");
ALTER TABLE "exercise_check_in_to_challenge_assigments"
ADD CONSTRAINT "exercise_check_in_to_challenge_assigments_exercise_check_in_id_foreign" FOREIGN KEY("exercise_check_in_id") REFERENCES "exercise_check_ins"("id");
ALTER TABLE "exercise_check_in_to_challenge_assigments"
ADD CONSTRAINT "exercise_check_in_to_challenge_assigments_gym_challenge_id_foreign" FOREIGN KEY("gym_challenge_id") REFERENCES "gym_challenges"("id");
ALTER TABLE "gym_challenge_memberships"
ADD CONSTRAINT "gym_challenge_memberships_gym_challenge_id_foreign" FOREIGN KEY("gym_challenge_id") REFERENCES "gym_challenges"("id");
ALTER TABLE "exercise_check_ins"
ADD CONSTRAINT "exercise_check_ins_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE "gym_challenge_memberships"
ADD CONSTRAINT "gym_challenge_memberships_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE "gym_challenge_memberships"
ADD CONSTRAINT "gym_challenge_memberships_role_id_foreign" FOREIGN KEY("role_id") REFERENCES "app_roles"("id");
ALTER TABLE "app_roles_assignments"
ADD CONSTRAINT "app_roles_assignments_app_role_id_foreign" FOREIGN KEY("app_role_id") REFERENCES "app_roles"("id");
ALTER TABLE "app_roles_assignments"
ADD CONSTRAINT "app_roles_assignments_permission_id_foreign" FOREIGN KEY("permission_id") REFERENCES "permissions"("id");