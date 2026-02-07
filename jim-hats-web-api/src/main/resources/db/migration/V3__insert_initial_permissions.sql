-- Insert permissions
INSERT INTO permissions(name)
VALUES ('USERS:LIST'),
    ('USERS:CREATE'),
    ('USERS:READ'),
    ('USERS:UPDATE'),
    ('USERS:DELETE'),
    ('ROLES:LIST'),
    ('ROLES:CREATE'),
    ('ROLES:READ'),
    ('ROLES:UPDATE'),
    ('ROLES:DELETE') 
ON CONFLICT (name) DO NOTHING;

-- Assign all permissions to SYSTEM_ADMIN role
INSERT INTO system_roles_assignments(system_role_id, permission_id)
SELECT 
    sr.id,
    p.id
FROM 
    system_roles sr
CROSS JOIN 
    permissions p
WHERE 
    sr.name = 'SYSTEM_ADMIN'
ON CONFLICT DO NOTHING;