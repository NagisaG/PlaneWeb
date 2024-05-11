package com.gzl.service;

import com.gzl.domain.Plane;
import java.util.List;
public interface PlaneService {
    List<Plane> findAllPlanes();

    int deletePlane(Plane plane);

    List<Plane> getPlaneById(int id);

    int updatePlane(Plane plane);

    int insertPlane(Plane plane);
}
