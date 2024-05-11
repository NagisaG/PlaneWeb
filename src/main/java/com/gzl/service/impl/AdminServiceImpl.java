package com.gzl.service.impl;

import com.gzl.domain.Admin;
import com.gzl.mapper.AdminMapper;
import com.gzl.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 名称:AdminServiceImpl
 * 描述:
 *
 * @version 1.0
 * @author:Nagisa
 * @datetime:2023-11-18 21:55
 */
@Primary
@Service
public class AdminServiceImpl implements AdminService {
    @Autowired(required = false)
    private AdminMapper adminMapper;

    @Override
    public List<Admin> logInSearch(String name, String password) {
        return adminMapper.findAdminByUsernameAndPassword(name, password);
    }

    @Override
    public String permissionCheck(String name) {
        return adminMapper.permissionCheck(name);
    }

    @Override
    public List<Admin> findAllAdmins() {
        return adminMapper.findAllAdmins();
    }

    @Override
    public int insertAdmin(Admin admin) {
        return adminMapper.insertAdmin(admin);
    }

    @Override
    public List<Admin> findAdminByUsername(String username) {
        return adminMapper.findAdminByUsername(username);
    }
    @Override
    public List<Admin> findAdminByPermission(String permission){
        return  adminMapper.findeAdminByPermission(permission);
    }

    @Override
    public int updateAdmin(Admin admin) {
        return adminMapper.updateAdmin(admin);
    }

    @Override
    public int deleteAdmin(Admin admin) {
        return adminMapper.deleteAdmin(admin);
    }

    @Override
    public List<Admin> getAdminById(int id) {
        return adminMapper.getAdminById(id);
    }

}
