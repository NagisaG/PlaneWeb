package com.gzl.service.impl;

import com.gzl.domain.Type;
import com.gzl.mapper.TypeMapper;
import com.gzl.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 名称:TypeServiceImpl
 * 描述:
 *
 * @version 1.0
 * @author:Nagisa
 * @datetime:2023-12-06 09:44
 */
@Primary
@Service
public class TypeServiceImpl implements TypeService {
    @Autowired(required = false)
    private TypeMapper typeMapper;
    @Override
    public List<Type> findAllTypesAndPlanes() {
        return typeMapper.findAllTypesWithPlanes();
    }

    @Override
    @Transactional
    public int deleteTypeAndPlanes(Integer typeId) {

        typeMapper.deletePlanesByTypeId(typeId);

// 删除 t_type 表中的记录
        return typeMapper.deleteType(typeId);
    }

    @Override
    public List<Type> findTypeById(Integer ptype) {
        return typeMapper.getTypeById(ptype);
    }

    @Override
    public List<Type> findAllType() {
        return typeMapper.findAllType();
    }

    @Override
    public int insertType(Type type) {
        return typeMapper.insertType(type);
    }

    @Override
    public int updateType(Type type) {
        return typeMapper.updateType(type);
    }

    @Override
    public List<Type> getTypeById(Integer ptype) {
        return typeMapper.findTypeById(ptype);
    }


}
