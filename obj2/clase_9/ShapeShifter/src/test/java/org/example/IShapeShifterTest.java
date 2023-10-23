package org.example;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class IShapeShifterTest {

    ShapeShifterNode nodeA;
    ShapeShifterNode nodeB;
    ShapeShifterNode nodeC;
    ShapeShifterNode nodeD;
    IShapeShifter shapeShifterComposedFromNodesAAndB;
    IShapeShifter shapeShifterComposedFromNodesCAndD;

    @BeforeEach
    public void setup() {
        nodeA = new ShapeShifterNode(1);
        nodeB = new ShapeShifterNode(2);
        nodeC = new ShapeShifterNode(4);
        nodeD = new ShapeShifterNode(10);
        shapeShifterComposedFromNodesAAndB = nodeA.compose(nodeB);
        shapeShifterComposedFromNodesCAndD = nodeC.compose(nodeD);
    }

    @Test
    public void testNodeANodeBComposeShapeShifterStructure() {
        List<Integer> expectedShapeShifterList = new ArrayList<>();
        expectedShapeShifterList.add(1);
        expectedShapeShifterList.add(2);
        Assertions.assertIterableEquals(expectedShapeShifterList, shapeShifterComposedFromNodesAAndB.values());
    }

    @Test
    public void testZeroDeep() {
        assertEquals(0, nodeA.deepest());
    }

    @Test
    public void testTwoDeep() {
        IShapeShifter composedShapeShifter = shapeShifterComposedFromNodesAAndB.compose(shapeShifterComposedFromNodesCAndD);
        assertEquals(2, composedShapeShifter.deepest());
    }

    @Test
    public void testDoubleGroupValuesStructure() {
        IShapeShifter composedShapeShifter = shapeShifterComposedFromNodesAAndB.compose(shapeShifterComposedFromNodesCAndD);

        List<Integer> expectedShapeShifterStructure = new ArrayList<>();
        expectedShapeShifterStructure.add(1);
        expectedShapeShifterStructure.add(2);
        expectedShapeShifterStructure.add(4);
        expectedShapeShifterStructure.add(10);

        Assertions.assertIterableEquals(expectedShapeShifterStructure, composedShapeShifter.values());
    }

    @Test
    public void testZeroElements() {
        ShapeShifterGroup emptyShapeShifter = new ShapeShifterGroup();
        assertIterableEquals(new ArrayList<>(), emptyShapeShifter.values());
    }

}