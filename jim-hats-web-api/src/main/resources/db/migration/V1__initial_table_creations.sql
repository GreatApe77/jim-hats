CREATE TABLE "permissions" (
    "id" BIGSERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL
);

CREATE TABLE "app_roles" (
    "id" BIGSERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL
);

CREATE TABLE "app_roles_assignments" (
    "id" BIGSERIAL PRIMARY KEY,
    "app_role_id" BIGINT NOT NULL,
    "permission_id" BIGINT NOT NULL
);

CREATE TABLE "users" (
    "id" BIGSERIAL PRIMARY KEY,
    "first_name" VARCHAR(255) NOT NULL,
    "last_name" VARCHAR(255) NOT NULL,
    "username" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) UNIQUE NOT NULL,
    "profile_picture_url" VARCHAR(255),
    "password" VARCHAR(255) NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NOT NULL
);

CREATE TABLE "gym_challenges" (
    "id" BIGSERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "banner_img_url" VARCHAR(255) NOT NULL,
    "created_at" DATE NOT NULL,
    "start_at" DATE NOT NULL,
    "end_at" DATE NOT NULL
);

CREATE TABLE "gym_challenge_memberships" (
    "id" BIGSERIAL PRIMARY KEY,
    "user_id" BIGINT NOT NULL,
    "gym_challenge_id" BIGINT NOT NULL,
    "role_id" BIGINT NOT NULL,
    "created_at" DATE NOT NULL
);

CREATE TABLE "exercise_check_ins" (
    "id" BIGSERIAL PRIMARY KEY,
    "title" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "created_at" DATE NOT NULL,
    "user_id" BIGINT NOT NULL,
    "exercise_img_url" VARCHAR(255) NOT NULL
);

CREATE TABLE "exercise_check_in_to_challenge_assigments" (
    "id" BIGSERIAL PRIMARY KEY,
    "exercise_check_in_id" BIGINT NOT NULL,
    "gym_challenge_id" BIGINT NOT NULL
);

ALTER TABLE "exercise_check_in_to_challenge_assigments"
ADD CONSTRAINT "exercise_check_in_to_challenge_assigments_exercise_check_in_id_foreign"
FOREIGN KEY ("exercise_check_in_id") REFERENCES "exercise_check_ins" ("id");

ALTER TABLE "exercise_check_in_to_challenge_assigments"
ADD CONSTRAINT "exercise_check_in_to_challenge_assigments_gym_challenge_id_foreign"
FOREIGN KEY ("gym_challenge_id") REFERENCES "gym_challenges" ("id");

ALTER TABLE "gym_challenge_memberships"
ADD CONSTRAINT "gym_challenge_memberships_gym_challenge_id_foreign"
FOREIGN KEY ("gym_challenge_id") REFERENCES "gym_challenges" ("id");

ALTER TABLE "exercise_check_ins"
ADD CONSTRAINT "exercise_check_ins_user_id_foreign"
FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "gym_challenge_memberships"
ADD CONSTRAINT "gym_challenge_memberships_user_id_foreign"
FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "gym_challenge_memberships"
ADD CONSTRAINT "gym_challenge_memberships_role_id_foreign"
FOREIGN KEY ("role_id") REFERENCES "app_roles" ("id");

ALTER TABLE "app_roles_assignments"
ADD CONSTRAINT "app_roles_assignments_app_role_id_foreign"
FOREIGN KEY ("app_role_id") REFERENCES "app_roles" ("id");

ALTER TABLE "app_roles_assignments"
ADD CONSTRAINT "app_roles_assignments_permission_id_foreign"
FOREIGN KEY ("permission_id") REFERENCES "permissions" ("id");
