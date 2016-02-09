package whatever

import org.scalatest.FunSuite
import org.scalatest.prop.Checkers
import org.scalacheck.Arbitrary.arbitrary
import org.scalacheck.Gen
import org.scalacheck.Prop.forAll

object WhateverSpec {
  import org.scalatest.Assertions._
}

class WhateverSpec extends FunSuite with Checkers {
  import WhateverSpec._

  private[this] val minSuccessful = 100

  implicit override val generatorDrivenConfig =
    PropertyCheckConfig(minSuccessful = minSuccessful, maxDiscarded = 5 * minSuccessful)

  test("simple test") {
    assert(Whatever.one == 1)
  }

  test("test with gens") {
    check {
      forAll(arbitrary[Int]) { i =>
        i == i
      }
    }
  }
}