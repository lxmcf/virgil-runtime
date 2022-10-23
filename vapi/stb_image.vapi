[CCode (cprefix = "stbi_", cheader_filename = "stb_image.h")]
namespace Stbi {
    [CCode (cname = "int" , cprefix = "STBI_")]
    enum Channels {
        [CCode (cname = "STBI_default")]
        DEFAULT,
        [CCode (cname = "STBI_grey")]
        GREY,
        [CCode (cname = "STBI_grey_alpha")]
        GREY_ALPHA,
        [CCode (cname = "STBI_rgb")]
        RGB,
        [CCode (cname = "STBI_rgb_alpha")]
        RGB_ALPHA
    }

    ////////////////////////////////////
    //
    //
    // 8-bits-per-channel interface
    //
    ////////////////////////////////////

    /**
     * Loads an image file and returns a generic pointer.
     *
     * This function takes in a file and returns a generic pointer while outputting image data.
     * However this function has the below imitations as part of stb_image:
     * * No 12 bits per chanel JPEG
     * * No JPEGs with arithmetic coding
     * * GIF always returns 4 bits per pixel
     *
     * As this function return's a generic pointer, the memory will need to manually free'd like below:
     *
     * {{{
     *  void* pixel_data = Stbi.load ("example.png", out width, out height, out bpp);
     *
     *  // Image processing code
     *
     *  delete pixel_data;
     * }}}
     *
     * @param string File to load
     * @param int Returns the image width
     * @param int Returns the image height
     * @param int Returns the amount of colour channels
     * @param int Requested amount of image components
     * @return uchar* Pointer to image pixel data
     */
    [CCode (cname = "stbi_load")]
    public static uchar* load (string file, out int width, out int height, out int channels, int desired_channels = 4);

    /**
     * Loads an image filestream and returns a generic pointer.
     *
     * This function takes in a file and returns a generic pointer while outputting image data.
     * This function inherits the same limitations as Stbi.load ();
     *
     *
     * @see Stbi.load
     * @param GLib.FileStream FileStream to load
     * @param int Returns the image width
     * @param int Returns the image height
     * @param int Returns the amount of colour channels
     * @param int Requested amount of image components
     * @return uchar* Pointer to image pixel data
     */
    [CCode (cname = "stbi_load_from_file")]
    public static uchar* load_from_filestream (GLib.FileStream file, out int width, out int height, out int channels, int desired_channels = 4);

    /**
     * Loads an image buffer and returns a generic pointer.
     *
     * This function takes in a file and returns a generic pointer while outputting image data.
     * This function inherits the same limitations as Stbi.load ();
     *
     *
     * @see Stbi.load
     * @param void* File buffer to load
     * @param int Returns the image width
     * @param int Returns the image height
     * @param int Returns the amount of colour channels
     * @param int Requested amount of image components
     * @return Generic pointer to image pixel data
     */
    [CCode (cname = "stbi_load_from_memory")]
    public static uchar* load_from_memory (void* mem, int length, out int width, out int height, out int bpp, int desired_channels = 4);

    ////////////////////////////////////
    //
    // 16-bits-per-channel interface
    //
    ////////////////////////////////////

    /**
     * Loads an image file and returns a generic pointer.
     *
     * This function takes in a file and returns a generic pointer while outputting image data.
     * However this function has the below imitations as part of stb_image:
     * * No 12 bits per chanel JPEG
     * * No JPEGs with arithmetic coding
     * * GIF always returns 4 bits per pixel
     *
     * As this function return's a generic pointer, the memory will need to manually free'd like below:
     *
     * {{{
     *  void* pixel_data = Stbi.load ("example.png", out width, out height, out bpp);
     *
     *  // Image processing code
     *
     *  delete pixel_data;
     * }}}
     *
     * @param string File to load
     * @param int Returns the image width
     * @param int Returns the image height
     * @param int Returns the amount of colour channels
     * @param int Requested amount of image components
     * @return uchar* Pointer to image pixel data
     */
    [CCode (cname = "stbi_load_16")]
    public static uchar* load_16 (string file, out int width, out int height, out int channels, int desired_channels = 4);

     /**
      * Loads an image filestream and returns a generic pointer.
      *
      * This function takes in a file and returns a generic pointer while outputting image data.
      * This function inherits the same limitations as Stbi.load_16 ();
      *
      *
      * @see Stbi.load
      * @param GLib.FileStream FileStream to load
      * @param int Returns the image width
      * @param int Returns the image height
      * @param int Returns the amount of colour channels
      * @param int Requested amount of image components
      * @return uchar* Pointer to image pixel data
      */
    [CCode (cname = "stbi_load_from_file_16")]
    public static uchar* load_16_from_filestream (GLib.FileStream file, out int width, out int height, out int channels, int desired_channels = 4);

     /**
      * Loads an image buffer and returns a generic pointer.
      *
      * This function takes in a file and returns a generic pointer while outputting image data.
      * This function inherits the same limitations as Stbi.load_16 ();
      *
      *
      * @see Stbi.load
      * @param void* File buffer to load
      * @param int Returns the image width
      * @param int Returns the image height
      * @param int Returns the amount of colour channels
      * @param int Requested amount of image components
      * @return uchar* Pointer to image pixel data
      */
     [CCode (cname = "stbi_load_16_from_memory")]
     public static uchar* load_16_from_memory (void* mem, int length, out int width, out int height, out int bpp, int desired_channels = 4);

    ////////////////////////////////////
    //
    // Load info
    //
    ////////////////////////////////////

    /*
     * Loads file info from given filename.
     *
     * This function takes in a file and outputs the width, height and channel count and will return 1 on success.
     *
     *
     * @param string File to load
     * @param int Returns the image width
     * @param int Returns the image height
     * @param int Returns the amount of colour channels
     * @@return int Returns an integer based on file load
     */
    [CCode (cname = "stbi_info")]
    public static int load_info (string file, out int width, out int height, out int channels);

    /*
     * Loads file info from given filestream.
     *
     * This function takes in a file and outputs the width, height and channel count and will return 1 on success.
     *
     *
     * @see @Stbi.load_info
     * @param string File to load
     * @param int Returns the image width
     * @param int Returns the image height
     * @param int Returns the amount of colour channels
     * @return int Returns an integer based on file load
     */
    [CCode (cname = "stbi_info_from_file")]
    public static int load_info_from_filestream (GLib.FileStream file, out int width, out int height, out int channels);

    ///////////////////////////////////
    //
    // High Dynamic Range (HDR)
    //
    ////////////////////////////////////

    /**
     * Sets the HDR to LDR gamma used when loading HDR images with Stbi.load ();
     *
     * @param float The desired gamma level
     */
    [CCode (cname = "stbi_hdr_to_ldr_gamma")]
    public static void set_hdr_to_ldr_gamma (float gamma);

    /**
     * Sets the HDR to LDR scale used when loading HDR images with Stbi.load ();
     *
     * @param float The desired scale
     */
    [CCode (cname = "stbi_hdr_to_ldr_scale")]
    public static void set_hdr_to_ldr_scale (float scale);

    /**
     * Sets the LDR to HDR gamma used when loading LDR images with Stbi.load ();
     *
     * @param float The desired gamma level
     */
    [CCode (cname = "stbi_ldr_to_hdr_gamma")]
    public static void set_ldr_to_hdr_gamma (float gamma);

    /**
     * Sets the LDR to HDR scale used when loading LDR images with Stbi.load ();
     *
     * @param float The desired gamma level
     */
    [CCode (cname = "stbi_ldr_to_hdr_scale")]
    public static void set_ldr_to_hdr_scale (float scale);

    /**
     * Indicates whether any given files should be flipped when loading.
     *
     * This function can be used to flip an image on load meaning the first read pixel is the bottom left.
     * This is required if working with raw OpenGL for example.
     *
     * @param bool Whether to flip
     */
    [CCode (cname = "stbi_set_flip_vertically_on_load")]
    public static void set_flip_vertically_on_load (bool flip);

    /**
     * Indicates whether to force a divide per pixel to remove any premultiplied alpha.
     *
     * @param bool Whether to unpremultiply
     */
    [CCode (cname = "stbi_set_unpremultiply_on_load")]
    public static void set_unpremultiply_on_load (bool unpremultiply);

    /**
     * Indicates whether to process iPhone images bac to normal RGB
     *
     * @param bool Whether to process image
     */
    [CCode (cname = "stbi_convert_iphone_png_to_rgb")]
    public static void set_convert_iphone_png_to_rgb (bool convert);

    /**
     * Returns whether the provided file is HDR or not.
     *
     * @param string The file to check
     * @return bool If file is HDR
     */
    [CCode (cname = "stbi_is_hdr")]
    public static bool is_file_hdr (string file);

    /**
     * Returns whether the provided file stream is HDR or not.
     *
     * @param GLib.FileStream The filestream to check
     * @return bool If file is HDR
     */
    [CCode (cname = "stbi_is_hdr_from_file")]
    public static bool is_file_hdr_from_filestream (GLib.FileStream file);

    /**
     * Returns whether the provided memory is HDR or not.
     *
     * @param GLib.FileStream The filestream to check
     * @return bool If file is HDR
     */
    [CCode (cname = "stbi_is_hdr_from_memory")]
    public static bool is_file_hdr_from_memory (void* mem, int length);

    /**
     * Returns whether the provided file is 16 bit or not.
     *
     * @param string The file to check
     * @return bool If file is 16 bit
     */
    [CCode (cname = "stbi_is_16_bit")]
    public static bool is_file_16_bit (string file);

    /**
     * Returns whether the provided file is 16 bit or not.
     *
     * @param GLib.FileStream The filestream to check
     * @return bool If file is 16 bit
     */
    [CCode (cname = "stbi_is_16_bit_from_file")]
    public static bool is_file_16_bit_from_filestream (GLib.FileStream file);

    /**
     * Returns whether the provided file is 16 bit or not.
     *
     * @param void* The memory to check
     * @return bool If file is 16 bit
     */
    [CCode (cname = "stbi_is_16_bit_from_memory")]
    public static bool is_file_16_bit_from_memory (void* mem, int length);

    /**
     * Free's memory returned from file loading functions.
     *
     * This fucntion will free the returned value from Stbi.load() functions, this is no different from delete mem;
     *
     * @param void* Memory to free
     */
    [CCode (cname = "stbi_image_free")]
    public static void image_free (void* mem);
}