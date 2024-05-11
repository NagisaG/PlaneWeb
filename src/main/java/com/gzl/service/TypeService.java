package com.gzl.service;

import com.gzl.domain.Type;

import java.util.List;

public interface TypeService {
    List<Type> findAllTypesAndPlanes();
    int deleteTypeAndPlanes(Integer typeId);
    List<Type> findTypeById(Integer ptype);
    List<Type> findAllType();
    int insertType(Type type);
    int updateType(Type type);
    List<Type> getTypeById(Integer ptype);

}
