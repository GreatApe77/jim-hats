package com.mateusnavarro77.jim_hats_web_api.auth.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.mateusnavarro77.jim_hats_web_api.auth.entity.Permission;

public interface PermissionRepository extends JpaRepository<Permission, Long> {
    Optional<Permission> findByName(String name);

    List<Permission> findBySystemRoles_Name(String systemRoleName);

    @Query("""
            SELECT CASE WHEN COUNT(sra) > 0 THEN true ELSE false END
            FROM SystemRoleAssignment sra
            WHERE sra.systemRole.name = :systemRoleName
            AND sra.permission.name = :permissionName
            """)
    boolean systemRoleHasPermissionByName(@Param("systemRoleName") String systemRoleName,
            @Param("permissionName") String permissionName);
}
