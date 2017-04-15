


class Voronoi {

// The set of points that control the centers of the cells
private LinkedList<Point> pts  = new LinkedList<Point>();
// A list of line segments that defines where the cells are divided
private LinkedList<Edge> output = new LinkedList<Edge>();
// The sites that have not yet been processed, in acending order of X coordinate
private PriorityQueue sites = new PriorityQueue();
// Possible upcoming cirlce events in acending order of X coordinate
private PriorityQueue events = new PriorityQueue();
// The root of the binary search tree of the parabolic wave front
private Arc root ;

void runFortune(LinkedList pts) {

    sites.clear();
    events.clear();
    output.clear();
    root = null;

    Point p;
    ListIterator i = pts.listIterator(0);
    while (i.hasNext()) {
        sites.offer(i.next());
    }

    // Process the queues; select the top element with smaller x coordinate.
    while (sites.size() > 0) {
        if ((events.size() > 0) && ((((CircleEvent) events.peek()).xpos) <= (((Point) sites.peek()).x))) {
            processCircleEvent((CircleEvent) events.poll());
        } else {
            //process a site event by adding a curve to the parabolic front
            frontInsert((Point) sites.poll());
        }
    }

    // After all points are processed, do the remaining circle events.
    while (events.size() > 0) {
        processCircleEvent((CircleEvent) events.poll());
    }

    // Clean up dangling edges.
    finishEdges();

}

private void processCircleEvent(CircleEvent event) {
    if (event.valid) {
        //start a new edge
        Edge edgy = new Edge(event.p);

        // Remove the associated arc from the front.
        Arc parc = event.a;
        if (parc.prev != null) {
            parc.prev.next = parc.next;
            parc.prev.edge1 = edgy;
        }
        if (parc.next != null) {
            parc.next.prev = parc.prev;
            parc.next.edge0 = edgy;
        }

        // Finish the edges before and after this arc.
        if (parc.edge0 != null) {
            parc.edge0.finish(event.p);
        }
        if (parc.edge1 != null) {
            parc.edge1.finish(event.p);
        }

        // Recheck circle events on either side of p:
        if (parc.prev != null) {
            checkCircleEvent(parc.prev, event.xpos);
        }
        if (parc.next != null) {
            checkCircleEvent(parc.next, event.xpos);
        }

    }
}

void frontInsert(Point focus) {
    if (root == null) {
        root = new Arc(focus);
        return;
    }

    Arc parc = root;
    while (parc != null) {
        CircleResultPack rez = intersect(focus, parc);
        if (rez.valid) {
            // New parabola intersects parc.  If necessary, duplicate parc.

            if (parc.next != null) {
                CircleResultPack rezz = intersect(focus, parc.next);
                if (!rezz.valid){
                    Arc bla = new Arc(parc.focus);
                    bla.prev = parc;
                    bla.next = parc.next;
                    parc.next.prev = bla;
                    parc.next = bla;
                }
            } else {
                parc.next = new Arc(parc.focus);
                parc.next.prev = parc;
            }
            parc.next.edge1 = parc.edge1;

            // Add new arc between parc and parc.next.
            Arc bla = new Arc(focus);
            bla.prev = parc;
            bla.next = parc.next;
            parc.next.prev = bla;
            parc.next = bla;

            parc = parc.next; // Now parc points to the new arc.

            // Add new half-edges connected to parc's endpoints.
            parc.edge0 = new Edge(rez.center);
            parc.prev.edge1 = parc.edge0;
            parc.edge1 = new Edge(rez.center);
            parc.next.edge0 = parc.edge1;

            // Check for new circle events around the new arc:
            checkCircleEvent(parc, focus.x);
            checkCircleEvent(parc.prev, focus.x);
            checkCircleEvent(parc.next, focus.x);

            return;
        }

        //proceed to next arc
        parc = parc.next;
    }

    // Special case: If p never intersects an arc, append it to the list.
    parc = root;
    while (parc.next != null) {
        parc = parc.next; // Find the last node.
    }
    parc.next = new Arc(focus);
    parc.next.prev = parc;
    Point start = new Point(0, (parc.next.focus.y + parc.focus.y) / 2);
    parc.next.edge0 = new Edge(start);
    parc.edge1 = parc.next.edge0;

}

void checkCircleEvent(Arc parc, double xpos) {
    // Invalidate any old event.
    if ((parc.event != null) && (parc.event.xpos != xpos)) {
        parc.event.valid = false;
    }
    parc.event = null;

    if ((parc.prev == null) || (parc.next == null)) {
        return;
    }

    CircleResultPack result = circle(parc.prev.focus, parc.focus, parc.next.focus);
    if (result.valid && result.rightmostX > xpos) {
        // Create new event.
        parc.event = new CircleEvent(result.rightmostX, result.center, parc);
        events.offer(parc.event);
    }

}

// Find the rightmost point on the circle through a,b,c.
CircleResultPack circle(Point a, Point b, Point c) {
    CircleResultPack result = new CircleResultPack();

    // Check that bc is a "right turn" from ab.
    if ((b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y) > 0) {
        result.valid = false;
        return result;
    }

    // Algorithm from O'Rourke 2ed p. 189.
    double A = b.x - a.x;
    double B = b.y - a.y;
    double C = c.x - a.x;
    double D = c.y - a.y;
    double E = A * (a.x + b.x) + B * (a.y + b.y);
    double F = C * (a.x + c.x) + D * (a.y + c.y);
    double G = 2 * (A * (c.y - b.y) - B * (c.x - b.x));

    if (G == 0) { // Points are co-linear.
        result.valid = false;
        return result;
    }

    // centerpoint of the circle.
    Point o = new Point((D * E - B * F) / G, (A * F - C * E) / G);
    result.center = o;

    // o.x plus radius equals max x coordinate.
    result.rightmostX = o.x + Math.sqrt(Math.pow(a.x - o.x, 2.0) + Math.pow(a.y - o.y, 2.0));

    result.valid = true;
    return result;
}

// Will a new parabola at point p intersect with arc i?
CircleResultPack intersect(Point p, Arc i) {
    CircleResultPack res = new CircleResultPack();
    res.valid = false;
    if (i.focus.x == p.x) {
        return res;
    }

    double a = 0.0;
    double b = 0.0;
    if (i.prev != null) // Get the intersection of i->prev, i.
    {
        a = intersection(i.prev.focus, i.focus, p.x).y;
    }
    if (i.next != null) // Get the intersection of i->next, i.
    {
        b = intersection(i.focus, i.next.focus, p.x).y;
    }

    if ((i.prev == null || a <= p.y) && (i.next == null || p.y <= b)) {
        res.center = new Point(0, p.y);

        // Plug it back into the parabola equation to get the x coordinate
        res.center.x = (i.focus.x * i.focus.x + (i.focus.y - res.center.y) * (i.focus.y - res.center.y) - p.x * p.x) / (2 * i.focus.x - 2 * p.x);

        res.valid = true;
        return res;
    }
    return res;
}

// Where do two parabolas intersect?
Point intersection(Point p0, Point p1, double l) {
    Point res = new Point(0, 0);
    Point p = p0;

    if (p0.x == p1.x) {
        res.y = (p0.y + p1.y) / 2;
    } else if (p1.x == l) {
        res.y = p1.y;
    } else if (p0.x == l) {
        res.y = p0.y;
        p = p1;
    } else {
        // Use the quadratic formula.
        double z0 = 2 * (p0.x - l);
        double z1 = 2 * (p1.x - l);

        double a = 1 / z0 - 1 / z1;
        double b = -2 * (p0.y / z0 - p1.y / z1);
        double c = (p0.y * p0.y + p0.x * p0.x - l * l) / z0 - (p1.y * p1.y + p1.x * p1.x - l * l) / z1;

        res.y = (-b - Math.sqrt((b * b - 4 * a * c))) / (2 * a);
    }
    // Plug back into one of the parabola equations.
    res.x = (p.x * p.x + (p.y - res.y) * (p.y - res.y) - l * l) / (2 * p.x - 2 * l);
    return res;
}

void finishEdges() {
    // Advance the sweep line so no parabolas can cross the bounding box.
    double l = width * 2 + height;

    // Extend each remaining segment to the new parabola intersections.
    Arc i = root;
    while (i != null) {
        if (i.edge1 != null) {
            i.edge1.finish(intersection(i.focus, i.next.focus, l * 2));
        }
        i = i.next;
    }
}

Point createPoint(double X, double Y)
{
  return new Point(X,Y);
}

class Point implements Comparable<Point> {

    public double x, y;
    //public Point goal;

    public Point(double X, double Y) {
        x = X;
        y = Y;
    }

    public int compareTo(Point foo) {
        return ((Double) this.x).compareTo((Double) foo.x);
    }
}

class CircleEvent implements Comparable<CircleEvent> {

    public double xpos;
    public Point p;
    public Arc a;
    public boolean valid;

    public CircleEvent(double X, Point P, Arc A) {
        xpos = X;
        a = A;
        p = P;
        valid = true;
    }

    public int compareTo(CircleEvent foo) {
        return ((Double) this.xpos).compareTo((Double) foo.xpos);
    }
}

class Edge {

    public Point start, end;
    public boolean done;

    public Edge(Point p) {
        start = p;
        end = new Point(0, 0);
        done = false;
        output.add(this);
    }

    public void finish(Point p) {
        if (done) {
            return;
        }
        end = p;
        done = true;
    }
}

class Arc {
    //parabolic arc is the set of points eqadistant from a focus point and the beach line

    public Point focus;
    //these object exsit in a linked list
    public Arc next, prev;
    //
    public CircleEvent event;
    //
    public Edge edge0, edge1;

    public Arc(Point p) {
        focus = p;
        next = null;
        prev = null;
        event = null;
        edge0 = null;
        edge1 = null;
    }
}

class CircleResultPack {
    // stupid Java doesnt let me return multiple variables without doing this

    public boolean valid;
    public Point center;
    public double rightmostX;
}
}