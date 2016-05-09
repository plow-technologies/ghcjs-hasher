{-# LANGUAGE OverloadedStrings #-}
module GHCJS.Hasher
    (
      hasherInit
    , hasherAddOnChange
    , hasherOnInitialized
    , hasherGetHash
    , hasherGetURL
    , hasherSetHash
    ) where

import Data.JSString ()
import GHCJS.Types
import GHCJS.Foreign.Callback
import GHCJS.Marshal

-- | Init hasher
hasherInit :: IO ()
hasherInit = js_hasherInit

-- | Add a callback on change
-- First parameter is the new hash
-- Second parameter is the old hash
hasherAddOnChange :: Callback (JSVal -> JSVal -> IO ()) -> IO ()
hasherAddOnChange = js_hasherChangedAdd

-- | First parameter is the current hash
hasherOnInitialized :: Callback (JSVal -> IO ()) -> IO ()
hasherOnInitialized = js_hasherInitializedAdd

-- | Get the current hash
hasherGetHash :: IO JSString
hasherGetHash = js_hasherGetHash

-- | Get the full URL
hasherGetURL :: IO JSString
hasherGetURL = js_hasherGetURL


-- | Set the hash
hasherSetHash :: JSString -> IO ()
hasherSetHash = js_hasherSetHash


foreign import javascript unsafe "hasher.init()"
  js_hasherInit :: IO ()

foreign import javascript unsafe "hasher.changed.add($1)"
  js_hasherChangedAdd :: Callback a -> IO ()

foreign import javascript unsafe "hasher.initialized.add($1)"
  js_hasherInitializedAdd :: Callback a -> IO ()

foreign import javascript unsafe "hasher.getHash()"
  js_hasherGetHash :: IO JSString

foreign import javascript unsafe "hasher.getURL()"
  js_hasherGetURL :: IO JSString

foreign import javascript unsafe "hasher.setHash($1)"
  js_hasherSetHash :: JSString -> IO ()