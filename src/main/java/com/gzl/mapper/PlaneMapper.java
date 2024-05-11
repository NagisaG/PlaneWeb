package com.gzl.mapper;

import com.gzl.domain.Plane;
import org.apache.ibatis.annotations.*;

import java.util.List;
@Mapper
public interface PlaneMapper {
    @Select("SELECT * FROM t_plane")
    @ResultMap("com.gzl.mapper.AdminMapper.planemap")
    List<Plane> findAllPlanes();

    @Delete("delete from t_plane where plane_id = #{plane.plane_id}")
    int deletePlane(@Param("plane") Plane plane);

    @Select("select * from t_plane where plane_id = #{id} ORDER BY cname ")
    @ResultMap("com.gzl.mapper.AdminMapper.planemap")
    List<Plane> getPlaneById(@Param("id") int id);

    @Select("select * from t_plane where ptype=#{type_id} ")
    @ResultMap("com.gzl.mapper.AdminMapper.planemap")
    List<Plane> getPlaneByType(@Param("type_id") int type_id);
    @Update("update t_plane set cname = #{plane.cname}, company = #{plane.company}, ename = #{plane.ename}, " +
            "ptype = #{plane.ptype}, image = #{plane.img}, first = #{plane.first}, license = #{plane.license}, " +
            "wings = #{plane.wings}, toUse = #{plane.usage}, seats = #{plane.seats}, flight = #{plane.flight}, " +
            "price = #{plane.price}, power = #{plane.power} where plane_id = #{plane.plane_id}")
    int updatePlane(@Param("plane") Plane plane);

    @Select("SELECT * FROM t_plane WHERE ptype = #{typeId}")
    @ResultMap("com.gzl.mapper.AdminMapper.planemap")
    List<Plane> findPlanesByTypeId(Integer typeId);

    @Insert("insert into t_plane(cname, company, ename, ptype, image, first, license, wings, toUse, seats, flight, price, power) " +
            "values(#{plane.cname}, #{plane.company}, #{plane.ename}, #{plane.ptype}, #{plane.img}, #{plane.first}, " +
            "#{plane.license}, #{plane.wings}, #{plane.usage}, #{plane.seats}, #{plane.flight}, #{plane.price}, #{plane.power})")
    int insertPlane(@Param("plane") Plane plane);

}
