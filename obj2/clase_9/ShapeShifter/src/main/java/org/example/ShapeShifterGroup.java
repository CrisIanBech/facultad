package org.example;

import java.util.ArrayList;
import java.util.List;

public class ShapeShifterGroup implements IShapeShifter {

    private List<IShapeShifter> shapeShifters;

    public ShapeShifterGroup() {
        shapeShifters = new ArrayList<>();
    }

    @Override
    public IShapeShifter compose(IShapeShifter otherShapeShifter) {
        ShapeShifterGroup anotherShapeShifter = new ShapeShifterGroup();
        anotherShapeShifter.insertShapeShifter(this);
        anotherShapeShifter.insertShapeShifter(otherShapeShifter);
        return anotherShapeShifter;
    }

    public void insertShapeShifter(IShapeShifter shapeShifterToInsert) {
        shapeShifters.add(shapeShifterToInsert);
    }

    @Override
    public int deepest() {
        return shapeShifters.stream().mapToInt(IShapeShifter::deepest).max().orElse(0) + 1;
    }

    @Override
    public IShapeShifter flat() {
        ShapeShifterGroup shapeShifterGroup = new ShapeShifterGroup();
        shapeShifters.stream()
                .flatMap(shapeShifter -> shapeShifter.values().stream())
                .map(ShapeShifterNode::new)
                .forEach(shapeShifterGroup::insertShapeShifter);
        return shapeShifterGroup;
    }

    @Override
    public List<Integer> values() {
        return shapeShifters.stream().flatMap(shapeShifter -> shapeShifter.values().stream()).toList();
    }
}
