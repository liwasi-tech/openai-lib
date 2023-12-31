{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
module ValueObject.Entity.Error where

import GHC.Generics (Generic)
import Data.Aeson (FromJSON (parseJSON), ToJSON (toJSON), Options (fieldLabelModifier), genericParseJSON, genericToJSON, defaultOptions)
import Data.Text (Text)

data Error = Error
  { _type :: Text
  , _message :: Text
  , _param :: Maybe Text
  , _code :: Maybe Text
  } deriving (Show, Generic, Eq)

instance FromJSON Error where
  parseJSON = genericParseJSON defaultOptions { fieldLabelModifier = drop 1 }

instance ToJSON Error where
  toJSON = genericToJSON defaultOptions { fieldLabelModifier = drop 1 }

newError :: Text -> Error
newError message = Error {
  _type = "internal_library_error",
  _message = message,
  _param = Nothing,
  _code = Nothing
}
