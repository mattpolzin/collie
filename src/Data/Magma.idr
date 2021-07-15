module Data.Magma

import Data.Maybe

infixr 6 .*.

public export
record RawMagma where
  constructor MkRawMagma
  Carrier : Type
  Product : Carrier -> Carrier -> Carrier

namespace List
  public export
  rawMagma : (a : Type) -> RawMagma
  rawMagma a = MkRawMagma (List a) (++)

namespace String
  public export
  rawMagma : RawMagma
  rawMagma = MkRawMagma String (++)

namespace Unit
  public export
  rawMagma : RawMagma
  rawMagma = MkRawMagma Unit $ const $ const ()

namespace Maybe
  public export
  rawMagma : RawMagma -> RawMagma
  rawMagma magma = MkRawMagma (Maybe magma.Carrier)
    (\mx, my => do
    x <- mx
    y <- my
    pure (magma.Product x y))

public export
openMagma : (magma : RawMagma) -> Semigroup magma.Carrier
openMagma magma = MkSemigroup magma.Product
