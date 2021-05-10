package cn.ky.jzk.util;

/**
 * @Author: Kevin
 * @Date: 2021/5/9 19:01
 */
public interface GiteeImgBedConstant {

    String ACCESS_TOKEN = "c8087172e09df345bb0f90ec67214131";

    String OWNER = "Robot_Kevin";

    String REPO_NAME = "TypeChoImg";

    String CREATE_REPOS_MESSAGE = "Add";

    String IMG_FILE_DEST_PATH = "cct/";

    /**
     * 新建文件
     * <p>
     * owner*   仓库所属空间地址(企业、组织或个人的地址path)
     * repo*    仓库路径
     * path*    文件的路径
     * content* 文件内容, 要用 base64 编码
     * message* 提交信息
     * <p>
     * %s =>仓库所属空间地址(企业、组织或个人的地址path)  (owner)
     * %s => 仓库路径(repo)
     * %s => 文件的路径(path)
     */
    String CREATE_REPOS_URL = "https://gitee.com/api/v5/repos/%s/%s/contents/%s";
    /**
     * 请求建立page  如果建立了，可以刷新
     * <p>
     * owner*  仓库所属空间地址(企业、组织或个人的地址path)
     * repo*    仓库
     */
    String BUILD_PAGE_URL = "https://gitee.com/api/v5/repos/%s/%s/pages/builds";
    /**
     * TODO： gitpage请求路径
     * 示例："http://quxuecx.gitee.io/typechoblogimg/";
     */
    String GITPAGE_REQUEST_URL = "http://robot_kevin.gitee.io/typechoimg";

}
