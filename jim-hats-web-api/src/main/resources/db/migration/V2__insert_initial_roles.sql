INSERT INTO app_roles(name)
VALUES ('ADMIN'),
    ('MEMBER'),
    ('MODERATOR') ON CONFLICT (name) DO NOTHING;