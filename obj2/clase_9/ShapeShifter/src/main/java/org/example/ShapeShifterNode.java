package org.example;

import java.util.ArrayList;
import java.util.List;

public class ShapeShifterNode implements IShapeShifter {

    private Integer value;

    public ShapeShifterNode(Integer value) {
        this.value = value;
    }

    @Override
    public IShapeShifter compose(IShapeShifter anotherShapeShifter) {
        ShapeShifterGroup shapeShifterGroup = new ShapeShifterGroup();
        shapeShifterGroup.insertShapeShifter(this);
        shapeShifterGroup.insertShapeShifter(anotherShapeShifter);
        return shapeShifterGroup;
    }

    @Override
    public int deepest() {
        return 0;
    }

    @Override
    public IShapeShifter flat() {
        return this;
    }

    @Override
    public List<Integer> values() {
        List<Integer> individualList = new ArrayList<>();
        individualList.add(value);
        return individualList;
    }
}
