package com.gzl.mapper;


import com.gzl.domain.Admin;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface AdminMapper {

    @Select("select * from t_admin where username = #{username} and password = #{password}")
    @ResultMap("com.gzl.mapper.AdminMapper.adminmap")
    List<Admin> findAdminByUsernameAndPassword(@Param("username") String username, @Param("password") String password);

    @Select("select * from t_admin where username = #{username}")
    @ResultMap("com.gzl.mapper.AdminMapper.adminmap")
    List<Admin> findAdminByUsername(@Param("username") String username);

    @Select("select * from t_admin where permission = #{permission}")
    @ResultMap("com.gzl.mapper.AdminMapper.adminmap")
    List<Admin> findeAdminByPermission(@Param("permission") String permission);

    @Select("select * from t_admin where username = #{username}")
    @Results({
            @Result(column = "permission",property = "permission")
    })
    String permissionCheck(String name);
    @Select("select * from t_admin ORDER BY permission ASC")
    @ResultMap("com.gzl.mapper.AdminMapper.adminmap")
    List<Admin> findAllAdmins();
    @Insert("insert into t_admin(username,password,permission) values(#{username},#{password},#{permission}) ")
    int insertAdmin(Admin admin);

    @Update("update t_admin set username = #{admin.username}, password = #{admin.password}, permission = #{admin.permission} where id = #{admin.id}")
    int updateAdmin(@Param("admin") Admin admin);

    @Delete("delete from t_admin where id = #{admin.id}")
    int deleteAdmin(@Param("admin") Admin admin);

    @Select("select * from t_admin where id = #{id}")
    @ResultMap("com.gzl.mapper.AdminMapper.adminmap")
    List<Admin> getAdminById(@Param("id") int it);


}