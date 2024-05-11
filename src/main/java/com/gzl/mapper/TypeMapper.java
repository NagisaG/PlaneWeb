package com.gzl.mapper;

import com.gzl.domain.Type;
import org.apache.ibatis.annotations.*;

import java.util.List;
@Mapper
public interface TypeMapper {
    @Select("SELECT t.type_id, MAX(t.type_name) as type_name, MAX(t.type_img) as type_img, MAX(t.introduction) as introduction,\n" +
            "       GROUP_CONCAT(p.plane_id) as plane_ids, MAX(p.cname) as cname, MAX(p.company) as company, MAX(p.ename) as ename, MAX(p.ptype) as ptype,\n" +
            "       MAX(p.image) as image, MAX(p.first) as first, MAX(p.license) as license, MAX(p.wings) as wings, MAX(p.toUse) as toUse,\n" +
            "       MAX(p.seats) as seats, MAX(p.flight) as flight, MAX(p.price) as price, MAX(p.power) as power\n" +
            "FROM t_type t\n" +
            "LEFT JOIN t_plane p ON t.type_id = p.ptype\n" +
            "GROUP BY t.type_id;")
@Results({
        @Result(property = "type_id", column = "type_id"),
        @Result(property = "type_name", column = "type_name"),
        @Result(property = "type_img", column = "type_img"),
        @Result(property = "introduction", column = "introduction"),
        @Result(property = "planeList", column = "type_id", javaType = List.class,
                many = @Many(select = "com.gzl.mapper.PlaneMapper.findPlanesByTypeId"))
})
    List<Type> findAllTypesWithPlanes();

    @Select("SELECT t.type_id, MAX(t.type_name) as type_name, MAX(t.type_img) as type_img, MAX(t.introduction) as introduction,\n" +
            "       GROUP_CONCAT(p.plane_id) as plane_ids, MAX(p.cname) as cname, MAX(p.company) as company, MAX(p.ename) as ename, MAX(p.ptype) as ptype,\n" +
            "       MAX(p.image) as image, MAX(p.first) as first, MAX(p.license) as license, MAX(p.wings) as wings, MAX(p.toUse) as toUse,\n" +
            "       MAX(p.seats) as seats, MAX(p.flight) as flight, MAX(p.price) as price, MAX(p.power) as power\n" +
            "FROM t_type t\n" +
            "LEFT JOIN t_plane p ON t.type_id = p.ptype\n" +
            "WHERE t.type_id = #{typeId}\n" +  // Add this WHERE clause to filter by type_id
            "GROUP BY t.type_id ")
    @Results({
            @Result(property = "type_id", column = "type_id"),
            @Result(property = "type_name", column = "type_name"),
            @Result(property = "type_img", column = "type_img"),
            @Result(property = "introduction", column = "introduction"),
            @Result(property = "planeList", column = "type_id", javaType = List.class,
                    many = @Many(select = "com.gzl.mapper.PlaneMapper.findPlanesByTypeId"))
    })
    List<Type> findTypeById(@Param("typeId") Integer typeId);

//    @Delete("DELETE t_type, t_plane FROM t_type LEFT JOIN t_plane ON t_type.type_id = t_plane.ptype WHERE t_type.type_id = #{typeId}")
//    int deleteTypeAndPlanes(@Param("typeId") Integer typeId);
// 首先删除 t_plane 表中的相关记录
@Delete("DELETE FROM t_plane WHERE ptype = #{typeId}")
int deletePlanesByTypeId(@Param("typeId") Integer typeId);

    // 然后删除 t_type 表中的记录
    @Delete("DELETE FROM t_type WHERE type_id = #{typeId}")
    int deleteType(@Param("typeId") Integer typeId);
    @Update("UPDATE t_type SET type_name = #{type_name}, type_img = #{type_img}, introduction = #{introduction} WHERE type_id = #{type_id}")
    int updateType(Type type);

    @Select("select * from t_type where type_id =#{ptype}")
    @ResultMap("com.gzl.mapper.AdminMapper.typemap")
    List<Type> getTypeById(@Param("ptype") int ptye);

    @Select("select * from t_type ORDER BY type_id ASC")
    @ResultMap("com.gzl.mapper.AdminMapper.typemap")
    List<Type> findAllType();

    @Insert("INSERT INTO t_type (type_name, type_img, introduction) " +
            "VALUES (#{type_name}, #{type_img}, #{introduction})")
    int insertType(Type type);

}
