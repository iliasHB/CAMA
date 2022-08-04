abstract class Mapper<S, T> {
  T from(S s);
  S to(T t);
}
