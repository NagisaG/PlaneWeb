package com.gzl.service;

import com.gzl.domain.Admin;

import java.util.List;

public interface AdminService {
    List<Admin> logInSearch(String name, String password);
    String permissionCheck(String name);
    List<Admin> findAllAdmins();
    int insertAdmin(Admin admin);
    List<Admin> findAdminByUsername(String username);
    List<Admin> findAdminByPermission(String permission);
    int updateAdmin(Admin admin);
    int deleteAdmin(Admin admin);
    List<Admin> getAdminById(int id);
}
