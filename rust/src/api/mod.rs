use std::path::PathBuf;

use tokio::sync::RwLock;

pub mod cache;
pub mod factory_bind;
pub mod http_helper;
pub mod init;
pub mod mirrors;
pub mod type_bind;
pub mod config;
pub mod extern_api;
pub mod check_update;

lazy_static::lazy_static! {
    pub static ref ROOT_PATH:RwLock<PathBuf> = RwLock::new(PathBuf::new());
}
