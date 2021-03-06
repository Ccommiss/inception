<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */



// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wp_wordpress');

/** MySQL database username */
define( 'DB_USER', 'ccommiss');

/** MySQL database password */
define( 'DB_PASSWORD', 'CeciEstUnMdpDur7319#' );

/** MySQL hostname */
define( 'DB_HOST', 'mariadb' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'WJ4PH>tJq$aOB9)^u1EX9hfrzgliTv]!M[iD{9%Krq9_: !L!D9Uj1@h1Xr,TwOh' );
define( 'SECURE_AUTH_KEY',  '=kd**jdg~Y9XmQ2L-SQq }h3pTb+^xGChud7xU@0{n*0IRWY=uQ|6BjL!1[hM+jP' );
define( 'LOGGED_IN_KEY',    'Izw/%5n0Xy oS<Z*~T7`29i1aT@wEfl>vHrLjwKHMNShfg-,9^L9[YTMjSC:OUIr' );
define( 'NONCE_KEY',        '(+z$:cEm$eRMHpZPfgX9sp`:fr`YCr2f<>(4$xQLPj4bT}$9#W+~ZOtar2]n!F95' );
define( 'AUTH_SALT',        'VGOFTlZq1Y$Kj[6/nW0SJQK25(:i+nPnsWxW-XcN+m[|hpb~8d?=>&lHCW]@mirc' );
define( 'SECURE_AUTH_SALT', '007V[5V=ui`HtU/Yj?|JM[yl&fuG*nIe~5$p,!7H7Pww7)=4;`A(;c#rJdp5OD[Z' );
define( 'LOGGED_IN_SALT',   'Qs;C1A[AEfZqlF2~GOe0f4cumB?lDKx<ZHHjpQ,YL!{24;^4%`x7%gwz}6m<F:#q' );
define( 'NONCE_SALT',       'M8Wl x8D&1nBMtn.<F<Xi&n,nWD#yra5]zo QA+:yq[(hp3(q5y6Ylt82hcX*K]S' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';