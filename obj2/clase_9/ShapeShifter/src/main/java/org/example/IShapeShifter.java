package org.example;

import java.util.List;

public interface IShapeShifter {
    IShapeShifter compose(IShapeShifter shapeShifter);
    int deepest();
    IShapeShifter flat();
    List<Integer> values();
}
