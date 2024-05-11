package com.gzl.service.impl;

import com.gzl.domain.Plane;
import com.gzl.mapper.PlaneMapper;
import com.gzl.service.PlaneService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 名称:PlaneServiceImpl
 * 描述:
 *
 * @version 1.0
 * @author:Nagisa
 * @datetime:2023-12-05 23:19
 */
@Primary
@Service
public class PlaneServiceImpl implements PlaneService {
    @Autowired(required = false)
    private PlaneMapper planeMapper;

    @Override
    public List<Plane> findAllPlanes() {
        return planeMapper.findAllPlanes();
    }

    @Override
    public int deletePlane(Plane plane) {
        return planeMapper.deletePlane(plane);
    }

    @Override
    public List<Plane> getPlaneById(int id) {
        return planeMapper.getPlaneById(id);
    }

    @Override
    public int updatePlane(Plane plane) {
        return planeMapper.updatePlane(plane);
    }

    @Override
    public int insertPlane(Plane plane) {
        return planeMapper.insertPlane(plane);
    }
}
