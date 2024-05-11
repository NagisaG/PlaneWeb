package com.gzl.domain;

import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * 名称:Type
 * 描述:
 *
 * @version 1.0
 * @author:Nagisa
 * @datetime:2023-12-03 18:39
 */
public class Type {
    private Integer type_id;
    private String type_name;
    private String type_img;
    private String introduction;
    private List<Plane> planeList;

    public Integer getType_id() {
        return type_id;
    }

    public void setType_id(Integer type_id) {
        this.type_id = type_id;
    }

    public String getType_name() {
        return type_name;
    }

    public void setType_name(String type_name) {
        this.type_name = type_name;
    }

    public String getType_img() {
        return type_img;
    }

    public void setType_img(String type_img) {
        this.type_img = type_img;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public List<Plane> getPlaneList() {
        return planeList;
    }

    public void setPlaneList(List<Plane> planeList) {
        this.planeList = planeList;
    }

    @Override
    public String toString() {
        return "Type{" +
                "type_id=" + type_id +
                ", type_name='" + type_name + '\'' +
                ", type_img='" + type_img + '\'' +
                ", introduction='" + introduction + '\'' +
                ", planeList=" + planeList +
                '}';
    }
}
